<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
  <head>
    <meta charset="UTF-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <title>Chatbot | Dung & Hung Audio</title>
    <link rel="stylesheet" href="chatbot.css" />
    <link
      rel="stylesheet"
      href="https://fonts.googleapis.com/css2?family=Material+Symbols+Rounded:opsz,wght,FILL,GRAD@24,500,0,0"
    />
  </head>
  <body>
    <main class="chat-shell">
      <header class="chat-header">
        <div>
          <p class="badge">Trợ lý mua hàng</p>
          <h1>Chatbot Dung & Hung Audio</h1>
          <p>Xin chào, shop bán thiết bị âm thanh xin vui lòng phục vụ!</p>
        </div>
        <div class="header-actions">
          <button id="theme-btn" type="button" class="material-symbols-rounded">light_mode</button>
          <button id="clear-btn" type="button" class="material-symbols-rounded">delete</button>
        </div>
      </header>

      <section id="chat-list" class="chat-list"></section>

      <form id="chat-form" class="chat-form">
        <input
          id="chat-input"
          class="chat-input"
          type="text"
          placeholder="Nhập câu hỏi về sản phẩm, giá, vận chuyển..."
          required
        />
        <button id="stop-btn" type="button" class="material-symbols-rounded">stop_circle</button>
        <button type="submit" class="material-symbols-rounded send-btn">send</button>
      </form>
    </main>

    <script>
      window.APP_CONTEXT_PATH = "<%= request.getContextPath() %>";
    </script>
    <script src="chatbot.js"></script>
  </body>
</html>
