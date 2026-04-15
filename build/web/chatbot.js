const chatList = document.getElementById("chat-list");
const chatForm = document.getElementById("chat-form");
const chatInput = document.getElementById("chat-input");
const clearBtn = document.getElementById("clear-btn");
const stopBtn = document.getElementById("stop-btn");
const themeBtn = document.getElementById("theme-btn");

const APP_CONTEXT_PATH = window.APP_CONTEXT_PATH || "";
const API_URL = `${APP_CONTEXT_PATH}/ChatBoxServlet`;

let controller = null;
let typingTimer = null;

function scrollBottom() {
  chatList.scrollTop = chatList.scrollHeight;
}

function createMessage(text, type) {
  const div = document.createElement("div");
  div.className = `msg ${type}`;
  div.innerHTML =
    type === "bot"
      ? `<div class="avatar">AI</div><div class="bubble"></div>`
      : `<div class="bubble"></div>`;
  div.querySelector(".bubble").textContent = text;
  return div;
}

function welcome() {
  chatList.appendChild(
    createMessage("Xin chào, shop bán thiết bị âm thanh xin vui lòng phục vụ!", "bot")
  );
  scrollBottom();
}

function typing(text, target) {
  clearInterval(typingTimer);
  target.textContent = "";
  let i = 0;
  typingTimer = setInterval(() => {
    target.textContent += text.charAt(i);
    i += 1;
    scrollBottom();
    if (i >= text.length) clearInterval(typingTimer);
  }, 14);
}

async function askBot(message, botNode) {
  const bubble = botNode.querySelector(".bubble");
  controller = new AbortController();
  try {
    const res = await fetch(API_URL, {
      method: "POST",
      headers: { "Content-Type": "application/json" },
      body: JSON.stringify({ message }),
      signal: controller.signal
    });

    const data = await res.json();
    if (!res.ok) throw new Error(data.error || "Lỗi máy chủ");
    typing(data.reply || "Mình chưa có phản hồi phù hợp.", bubble);
  } catch (err) {
    bubble.textContent =
      err.name === "AbortError"
        ? "Đã dừng phản hồi."
        : "Hệ thống đang bận. Bạn vui lòng thử lại sau ít phút.";
  }
}

chatForm.addEventListener("submit", (e) => {
  e.preventDefault();
  const message = chatInput.value.trim();
  if (!message) return;
  chatInput.value = "";

  chatList.appendChild(createMessage(message, "user"));
  const loading = createMessage("Đang xử lý...", "bot");
  chatList.appendChild(loading);
  scrollBottom();
  askBot(message, loading);
});

stopBtn.addEventListener("click", () => {
  controller?.abort();
  clearInterval(typingTimer);
});

clearBtn.addEventListener("click", () => {
  chatList.innerHTML = "";
  welcome();
});

themeBtn.addEventListener("click", () => {
  document.body.classList.toggle("dark");
});

welcome();
