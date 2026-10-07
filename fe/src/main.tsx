import { StrictMode } from "react";
import { createRoot } from "react-dom/client";
import { App } from "./App";
import { WebsiteIdentityProvider } from "./app/WebsiteIdentityContext";
import "./styles.css";

const root = document.getElementById("root");

if (!root) {
  throw new Error("Missing #root element");
}

createRoot(root).render(
  <StrictMode>
    <WebsiteIdentityProvider>
      <App />
    </WebsiteIdentityProvider>
  </StrictMode>,
);
