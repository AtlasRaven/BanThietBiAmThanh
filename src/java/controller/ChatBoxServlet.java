/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controller;

import java.io.IOException;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.BufferedReader;
import java.io.InputStream;
import java.io.InputStreamReader;
import java.io.OutputStream;
import java.nio.charset.StandardCharsets;
import java.net.HttpURLConnection;
import java.net.URL;
import java.util.List;
import java.util.Locale;
import java.util.ArrayList;
import java.util.Comparator;
import java.util.regex.Matcher;
import java.util.regex.Pattern;
import model.SanPham;
import model.SanPhamDao;
import org.json.JSONArray;
import org.json.JSONObject;

/**
 *
 * @author ASUS
 */
@WebServlet(name = "ChatBoxServlet", urlPatterns = {"/ChatBoxServlet"})
public class ChatBoxServlet extends HttpServlet {

    private static final String API_KEY = "AIzaSyB26oSCJnW99U35dNCHPU0paQhPh25lxHA";
    private static final String GEMINI_API_BASE = "https://generativelanguage.googleapis.com/v1beta";

    // <editor-fold defaultstate="collapsed" desc="HttpServlet methods. Click on the + sign on the left to edit the code.">
    /**
     * Handles the HTTP <code>GET</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("application/json");
        response.setCharacterEncoding("UTF-8");
        response.setStatus(HttpServletResponse.SC_METHOD_NOT_ALLOWED);

        JSONObject message = new JSONObject();
        message.put("error", "Vui long gui POST JSON den ChatBoxServlet.");
        response.getWriter().write(message.toString());
    }

    /**
     * Handles the HTTP <code>POST</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("application/json");
        response.setCharacterEncoding("UTF-8");

        String contentType = request.getContentType();
        if (contentType == null || !contentType.toLowerCase().contains("application/json")) {
            response.setStatus(HttpServletResponse.SC_BAD_REQUEST);
            JSONObject error = new JSONObject();
            error.put("error", "Content-Type phai la application/json.");
            response.getWriter().write(error.toString());
            return;
        }

        StringBuilder sb = new StringBuilder();
        try (BufferedReader reader = request.getReader()) {
            String line;
            while ((line = reader.readLine()) != null) {
                sb.append(line);
            }
        }

        try {
            String body = sb.toString().trim();

            if (body.isEmpty() || !body.startsWith("{")) {
                throw new Exception("Request khong phai JSON hop le!");
            }

            JSONObject json = new JSONObject(body);
            String userMessage = extractUserMessage(json);

            if (userMessage.isEmpty()) {
                throw new Exception("Noi dung tin nhan khong duoc de trong.");
            }

            String localReply = getLocalSupportReply(userMessage);
            if (localReply != null) {
                JSONObject responseBody = new JSONObject();
                responseBody.put("reply", localReply);
                response.getWriter().write(responseBody.toString());
                return;
            }

            String modelName = resolveAvailableModel();
            URL url = new URL(GEMINI_API_BASE + "/" + modelName + ":generateContent?key=" + API_KEY);
            HttpURLConnection conn = (HttpURLConnection) url.openConnection();

            conn.setRequestMethod("POST");
            conn.setRequestProperty("Content-Type", "application/json");
            conn.setDoOutput(true);

            String prompt = buildSupportPrompt(userMessage);
            JSONObject part = new JSONObject().put("text", prompt);
            JSONObject content = new JSONObject().put("parts", new JSONArray().put(part));
            JSONObject root = new JSONObject().put("contents", new JSONArray().put(content));

            try (OutputStream os = conn.getOutputStream()) {
                os.write(root.toString().getBytes(StandardCharsets.UTF_8));
            }

            int status = conn.getResponseCode();
            InputStream stream = (status < 400) ? conn.getInputStream() : conn.getErrorStream();

            StringBuilder result = new StringBuilder();
            try (BufferedReader br = new BufferedReader(new InputStreamReader(stream, StandardCharsets.UTF_8))) {
                String output;
                while ((output = br.readLine()) != null) {
                    result.append(output);
                }
            }

            if (status >= 400) {
                throw new Exception("API Error: " + result.toString());
            }

            JSONObject resJson = new JSONObject(result.toString());
            String reply = resJson.getJSONArray("candidates")
                    .getJSONObject(0)
                    .getJSONObject("content")
                    .getJSONArray("parts")
                    .getJSONObject(0)
                    .getString("text");

            JSONObject responseBody = new JSONObject();
            responseBody.put("reply", reply);
            response.getWriter().write(responseBody.toString());

        } catch (Exception e) {
            response.setStatus(HttpServletResponse.SC_BAD_REQUEST);

            JSONObject error = new JSONObject();
            error.put("error", e.getMessage());

            response.getWriter().write(error.toString());
        }
    }

    /**
     * Returns a short description of the servlet.
     *
     * @return a String containing servlet description
     */
    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

    private String extractUserMessage(JSONObject json) {
        JSONArray contents = json.optJSONArray("contents");
        if (contents == null || contents.isEmpty()) {
            return "";
        }
        JSONObject firstContent = contents.optJSONObject(0);
        if (firstContent == null) {
            return "";
        }
        JSONArray parts = firstContent.optJSONArray("parts");
        if (parts == null || parts.isEmpty()) {
            return "";
        }
        JSONObject firstPart = parts.optJSONObject(0);
        if (firstPart == null) {
            return "";
        }
        return firstPart.optString("text", "").trim();
    }

    private String getLocalSupportReply(String userMessage) {
        String msg = userMessage.toLowerCase(Locale.ROOT);

        if (msg.contains("xin chao") || msg.contains("chao") || msg.contains("hello") || msg.contains("hi")) {
            return "Xin chao ban! Minh la tro ly ho tro cua shop. Ban can tu van san pham, van chuyen hay thanh toan?";
        }
        if (msg.contains("lien he") || msg.contains("hotline") || msg.contains("so dien thoai")) {
            return "Ban co the lien he shop qua hotline 0123 456 789 hoac email support@dunghung.vn (co the doi theo thong tin thuc te cua ban).";
        }
        if (msg.contains("van chuyen") || msg.contains("giao hang") || msg.contains("ship")) {
            return "Shop ho tro giao hang toan quoc. Thoi gian giao du kien 2-5 ngay lam viec tuy khu vuc.";
        }
        if (msg.contains("thanh toan") || msg.contains("cod") || msg.contains("chuyen khoan")) {
            return "Shop ho tro thanh toan COD va chuyen khoan. Ban vui long kiem tra thong tin o trang dat hang truoc khi xac nhan.";
        }

        if (containsProductIntent(msg)) {
            return queryProductsFromDatabase(msg, userMessage);
        }

        return null;
    }

    private String buildProductSuggestionReply() {
        SanPhamDao dao = new SanPhamDao();
        List<SanPham> products = dao.getAll();
        if (products == null || products.isEmpty()) {
            return "Hien tai minh chua lay duoc danh sach san pham. Ban vui long thu lai sau it phut.";
        }

        int limit = Math.min(3, products.size());
        StringBuilder sb = new StringBuilder("Shop dang co mot so san pham noi bat:\n");
        for (int i = 0; i < limit; i++) {
            SanPham sp = products.get(i);
            sb.append("- ").append(sp.getTenSP())
                    .append(" | Gia: ").append((long) sp.getDonGia())
                    .append(" VND | Con: ").append(sp.getSoLuong()).append("\n");
        }
        sb.append("Ban muon minh tu van theo ngan sach nao?");
        return sb.toString();
    }

    private String buildSupportPrompt(String userMessage) {
        return "Ban la chatbot ho tro khach hang cho website ban hang Dung & Hung.\n"
                + "Hay tra loi ngan gon, lich su, de hieu bang tieng Viet, toi da 6 cau.\n"
                + "Neu khach hoi ve mua hang/ship/thanh toan, dua ra huong dan cu the.\n"
                + "Cau hoi cua khach: " + userMessage;
    }

    private boolean containsProductIntent(String msg) {
        return msg.contains("san pham")
                || msg.contains("goi y")
                || msg.contains("tu van")
                || msg.contains("loa")
                || msg.contains("tai nghe")
                || msg.contains("am thanh")
                || msg.contains("gia")
                || msg.contains("duoi")
                || msg.contains("tren")
                || msg.contains("ton kho")
                || msg.contains("con hang");
    }

    private String queryProductsFromDatabase(String msg, String originalMessage) {
        SanPhamDao dao = new SanPhamDao();
        Double[] priceRange = extractPriceRange(msg);
        String keyword = extractKeyword(originalMessage);
        String sort = extractSort(msg);

        List<SanPham> products = dao.searchAdvanced(keyword, priceRange[0], priceRange[1], sort);
        if (products == null || products.isEmpty()) {
            products = dao.getAll();
        }
        if (products == null || products.isEmpty()) {
            return "Hien tai minh chua lay duoc danh sach san pham tu he thong.";
        }

        if (!keyword.isBlank()) {
            String keyLower = keyword.toLowerCase(Locale.ROOT);
            List<SanPham> filtered = new ArrayList<>();
            for (SanPham sp : products) {
                String ten = sp.getTenSP() == null ? "" : sp.getTenSP().toLowerCase(Locale.ROOT);
                String ma = sp.getMaSP() == null ? "" : sp.getMaSP().toLowerCase(Locale.ROOT);
                String loai = sp.getPhanLoai() == null ? "" : sp.getPhanLoai().toLowerCase(Locale.ROOT);
                if (ten.contains(keyLower) || ma.contains(keyLower) || loai.contains(keyLower)) {
                    filtered.add(sp);
                }
            }
            if (!filtered.isEmpty()) {
                products = filtered;
            }
        }

        if ("asc".equals(sort)) {
            products.sort(Comparator.comparingDouble(SanPham::getDonGia));
        } else if ("desc".equals(sort)) {
            products.sort((a, b) -> Double.compare(b.getDonGia(), a.getDonGia()));
        }

        return buildProductReply(products, keyword, priceRange);
    }

    private String extractKeyword(String originalMessage) {
        String cleaned = originalMessage.toLowerCase(Locale.ROOT)
                .replaceAll("(?i)san pham|goi y|tu van|toi can|cho toi|tim|kiem|gia|duoi|tren|tu|den|trieu|nghin|k|vnd|vnđ", " ")
                .replaceAll("[^\\p{L}\\p{N}\\s]", " ")
                .replaceAll("\\s+", " ")
                .trim();

        if (cleaned.length() < 2) {
            return "";
        }
        return cleaned;
    }

    private String extractSort(String msg) {
        if (msg.contains("re nhat") || msg.contains("thap nhat") || msg.contains("gia tang")) {
            return "asc";
        }
        if (msg.contains("dat nhat") || msg.contains("cao nhat") || msg.contains("gia giam")) {
            return "desc";
        }
        return "";
    }

    private Double[] extractPriceRange(String msg) {
        Double min = null;
        Double max = null;

        Pattern betweenPattern = Pattern.compile("(tu|từ)\\s*(\\d+[\\.,]?\\d*)\\s*(den|đến)\\s*(\\d+[\\.,]?\\d*)");
        Matcher betweenMatcher = betweenPattern.matcher(msg);
        if (betweenMatcher.find()) {
            min = parseMoneyToVnd(betweenMatcher.group(2), msg);
            max = parseMoneyToVnd(betweenMatcher.group(4), msg);
        }

        Pattern underPattern = Pattern.compile("(duoi|dưới)\\s*(\\d+[\\.,]?\\d*)");
        Matcher underMatcher = underPattern.matcher(msg);
        if (underMatcher.find()) {
            max = parseMoneyToVnd(underMatcher.group(2), msg);
        }

        Pattern overPattern = Pattern.compile("(tren|trên)\\s*(\\d+[\\.,]?\\d*)");
        Matcher overMatcher = overPattern.matcher(msg);
        if (overMatcher.find()) {
            min = parseMoneyToVnd(overMatcher.group(2), msg);
        }

        return new Double[]{min, max};
    }

    private Double parseMoneyToVnd(String rawValue, String msg) {
        double value = Double.parseDouble(rawValue.replace(",", "."));
        if (msg.contains("trieu")) {
            value = value * 1_000_000;
        } else if (msg.contains("nghin") || msg.contains("k")) {
            value = value * 1_000;
        }
        return value;
    }

    private String buildProductReply(List<SanPham> products, String keyword, Double[] priceRange) {
        int limit = Math.min(5, products.size());
        StringBuilder sb = new StringBuilder("Minh tim thay ").append(products.size()).append(" san pham");

        boolean hasKeyword = keyword != null && !keyword.isBlank();
        if (hasKeyword) {
            sb.append(" theo tu khoa '").append(keyword).append("'");
        }
        if (priceRange[0] != null || priceRange[1] != null) {
            sb.append(" theo muc gia ban yeu cau");
        }
        sb.append(":\n");

        for (int i = 0; i < limit; i++) {
            SanPham sp = products.get(i);
            sb.append("- ").append(sp.getTenSP())
                    .append(" | Ma: ").append(sp.getMaSP())
                    .append(" | Gia: ").append(String.format("%,.0f", sp.getDonGia())).append(" VND")
                    .append(" | Ton kho: ").append(sp.getSoLuong())
                    .append("\n");
        }

        if (products.size() > limit) {
            sb.append("... Con ").append(products.size() - limit).append(" san pham khac.\n");
        }
        sb.append("Ban muon minh loc tiep theo hang, khoang gia hay muc ton kho?");
        return sb.toString();
    }

    private String resolveAvailableModel() {
        HttpURLConnection conn = null;
        try {
            URL url = new URL(GEMINI_API_BASE + "/models?key=" + API_KEY);
            conn = (HttpURLConnection) url.openConnection();
            conn.setRequestMethod("GET");
            conn.setConnectTimeout(10000);
            conn.setReadTimeout(10000);

            int status = conn.getResponseCode();
            InputStream stream = (status < 400) ? conn.getInputStream() : conn.getErrorStream();
            if (stream == null) {
                return "models/gemini-2.0-flash";
            }

            StringBuilder result = new StringBuilder();
            try (BufferedReader br = new BufferedReader(new InputStreamReader(stream, StandardCharsets.UTF_8))) {
                String output;
                while ((output = br.readLine()) != null) {
                    result.append(output);
                }
            }

            if (status >= 400) {
                return "models/gemini-2.0-flash";
            }

            JSONObject modelsJson = new JSONObject(result.toString());
            JSONArray models = modelsJson.optJSONArray("models");
            if (models == null || models.isEmpty()) {
                return "models/gemini-2.0-flash";
            }

            String firstGenerateContentModel = null;
            for (int i = 0; i < models.length(); i++) {
                JSONObject model = models.optJSONObject(i);
                if (model == null) {
                    continue;
                }

                JSONArray methods = model.optJSONArray("supportedGenerationMethods");
                if (!supportsGenerateContent(methods)) {
                    continue;
                }

                String name = model.optString("name", "");
                if (name.isEmpty()) {
                    continue;
                }

                if (firstGenerateContentModel == null) {
                    firstGenerateContentModel = name;
                }
                if (name.contains("flash")) {
                    return name;
                }
            }

            return firstGenerateContentModel != null ? firstGenerateContentModel : "models/gemini-2.0-flash";
        } catch (Exception e) {
            return "models/gemini-2.0-flash";
        } finally {
            if (conn != null) {
                conn.disconnect();
            }
        }
    }

    private boolean supportsGenerateContent(JSONArray methods) {
        if (methods == null) {
            return false;
        }
        for (int i = 0; i < methods.length(); i++) {
            String method = methods.optString(i, "");
            if ("generateContent".equals(method)) {
                return true;
            }
        }
        return false;
    }

}
