<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<!--
Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Html.html to edit this template
-->
<html>
  <head>
    <title>Chatbox</title>
    <meta charset="UTF-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <link rel="stylesheet" href="style.css" />
    <link
      rel="stylesheet"
      href="https://fonts.googleapis.com/css2?family=Material+Symbols+Rounded:opsz,wght,FILL,GRAD@32,400,0,0"
    />
  </head>
  <body>
    <div class="container">
      <!-- App Header -->
      <header class="app-header">
        <h1 class="heading">Hello, there</h1>
        <h4 class="sub-heading">How can I help you today?</h4>
      </header>
      <!-- Chats -->
      <div class="chats-container"></div>
      <!-- Prompt Input -->
      <div class="prompt-container">
        <div class="prompt-wrapper">
          <form action="#" class="prompt-form">
            <input
              type="text"
              placeholder="Ask Gemini"
              class="prompt-input"
              required
            />
            <div class="prompt-actions">
              <!-- File Upload Wrapper -->
              <div class="file-upload-wrapper">
                <img src="#" class="file-preview" />
                <input
                  id="file-input"
                  type="file"
                  accept="image/*, .pdf, .txt, .csv"
                  hidden
                />
                <button
                  type="button"
                  class="file-icon material-symbols-rounded"
                >
                  description
                </button>
                <button
                  id="cancel-file-btn"
                  type="button"
                  class="material-symbols-rounded"
                >
                  close
                </button>
                <button
                  id="add-file-btn"
                  type="button"
                  class="material-symbols-rounded"
                >
                  attach_file
                </button>
              </div>
              <!-- Send Prompt and Stop Response Buttons -->
              <button
                id="stop-response-btn"
                type="button"
                class="material-symbols-rounded"
              >
                stop_circle
              </button>
              <button id="send-prompt-btn" class="material-symbols-rounded">
                arrow_upward
              </button>
            </div>
          </form>
          <!-- Theme and Delete Chats Buttons -->
          <button id="theme-toggle-btn" class="material-symbols-rounded">
            light_mode
          </button>
          <button id="delete-chats-btn" class="material-symbols-rounded">
            delete
          </button>
        </div>
        <p class="disclaimer-text">
          Gemini can make mistakes, so double-check it.
        </p>
      </div>
    </div>
    <script>
      window.APP_CONTEXT_PATH = "<%= request.getContextPath() %>";
    </script>
    <script src="Script.js"></script>
  </body>
</html>
