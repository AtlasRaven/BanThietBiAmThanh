package controller;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStream;
import java.io.InputStreamReader;
import java.io.OutputStream;
import java.net.HttpURLConnection;
import java.net.URL;
import java.nio.charset.StandardCharsets;
import java.util.Locale;
import org.json.JSONArray;
import org.json.JSONObject;

@WebServlet(name = "ChatBoxServlet", urlPatterns = {"/ChatBoxServlet"})
public class ChatBoxServlet extends HttpServlet {

    private static final String API_KEY = "AIzaSyB26oSCJnW99U35dNCHPU0paQhPh25lxHA";
    private static final String GEMINI_API_BASE = "https://generativelanguage.googleapis.com/v1beta";
    private static final String MODEL = "models/gemini-2.0-flash";

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("application/json");
        response.setCharacterEncoding("UTF-8");
        try {
            String body = readBody(request);
            JSONObject json = new JSONObject(body);
            String message = json.optString("message", "").trim();
            if (message.isEmpty()) {
                writeError(response, HttpServletResponse.SC_BAD_REQUEST, "Nội dung tin nhắn không được để trống.");
                return;
            }

            String local = localReply(message);
            if (local != null) {
                writeReply(response, local);
                return;
            }

            writeReply(response, askGemini(message));
        } catch (Exception e) {
            writeError(response, HttpServletResponse.SC_BAD_REQUEST, "Không thể kết nối chatbot.");
        }
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        writeError(response, HttpServletResponse.SC_METHOD_NOT_ALLOWED, "Vui lòng gửi POST JSON.");
    }

    private String readBody(HttpServletRequest request) throws IOException {
        StringBuilder sb = new StringBuilder();
        try (BufferedReader br = request.getReader()) {
            String line;
            while ((line = br.readLine()) != null) {
                sb.append(line);
            }
        }
        return sb.toString();
    }

    private void writeReply(HttpServletResponse response, String reply) throws IOException {
        JSONObject obj = new JSONObject();
        obj.put("reply", reply);
        response.getWriter().write(obj.toString());
    }

    private void writeError(HttpServletResponse response, int code, String error) throws IOException {
        response.setStatus(code);
        JSONObject obj = new JSONObject();
        obj.put("error", error);
        response.getWriter().write(obj.toString());
    }

    private String askGemini(String message) throws Exception {
        URL url = new URL(GEMINI_API_BASE + "/" + MODEL + ":generateContent?key=" + API_KEY);
        HttpURLConnection conn = (HttpURLConnection) url.openConnection();
        conn.setRequestMethod("POST");
        conn.setRequestProperty("Content-Type", "application/json");
        conn.setDoOutput(true);

        JSONObject part = new JSONObject().put("text", buildPrompt(message));
        JSONObject content = new JSONObject().put("parts", new JSONArray().put(part));
        JSONObject body = new JSONObject().put("contents", new JSONArray().put(content));
        try (OutputStream os = conn.getOutputStream()) {
            os.write(body.toString().getBytes(StandardCharsets.UTF_8));
        }

        int status = conn.getResponseCode();
        String result = readStream(status < 400 ? conn.getInputStream() : conn.getErrorStream());
        if (status >= 400) {
            String lower = result.toLowerCase(Locale.ROOT);
            if (status == 429 || lower.contains("resource_exhausted") || lower.contains("quota")) {
                return "Hệ thống AI đang quá tải hoặc hết lượt. Bạn vui lòng thử lại sau ít phút.";
            }
            throw new Exception("AI error");
        }

        JSONObject res = new JSONObject(result);
        return res.getJSONArray("candidates")
                .getJSONObject(0)
                .getJSONObject("content")
                .getJSONArray("parts")
                .getJSONObject(0)
                .getString("text");
    }

    private String readStream(InputStream stream) throws IOException {
        if (stream == null) return "";
        StringBuilder sb = new StringBuilder();
        try (BufferedReader br = new BufferedReader(new InputStreamReader(stream, StandardCharsets.UTF_8))) {
            String line;
            while ((line = br.readLine()) != null) {
                sb.append(line);
            }
        }
        return sb.toString();
    }

    private String buildPrompt(String message) {
        return "Bạn là chatbot tư vấn cho shop thiết bị âm thanh Dung & Hung. "
                + "Trả lời tiếng Việt, ngắn gọn, lịch sự, dễ hiểu, tối đa 6 câu. "
                + "Câu hỏi khách: " + message;
    }

    private String localReply(String message) {
        String msg = message.toLowerCase(Locale.ROOT);
        if (msg.contains("xin chào") || msg.contains("chào") || msg.contains("hello")) {
            return "Xin chào! Mình có thể hỗ trợ bạn tư vấn sản phẩm, giá, vận chuyển và thanh toán.";
        }
        if (msg.contains("vận chuyển") || msg.contains("ship")) {
            return "Shop hỗ trợ giao hàng toàn quốc, dự kiến 2-5 ngày làm việc tùy khu vực.";
        }
        if (msg.contains("thanh toán") || msg.contains("cod") || msg.contains("chuyển khoản")) {
            return "Shop hỗ trợ thanh toán COD và chuyển khoản.";
        }
        return null;
    }
}
