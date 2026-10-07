import { spawn } from "node:child_process";
import puppeteer from "puppeteer-core";

const preview = spawn(process.execPath, ["node_modules/vite/bin/vite.js", "preview", "--port", "4193", "--strictPort"], { stdio: "ignore" });
await new Promise((r) => setTimeout(r, 2500));
const b = await puppeteer.launch({ executablePath: "C:\\Program Files\\Google\\Chrome\\Application\\chrome.exe", headless: "new", args: ["--no-sandbox"] });
const p = await b.newPage();
p.on("response", (r) => { if (r.url().includes("/api/")) console.log("API:", r.url(), r.status()); });
p.on("requestfailed", (r) => console.log("REQFAIL:", r.url().slice(0, 90)));
p.on("pageerror", (e) => console.log("PAGEERR:", String(e).slice(0, 150)));
await p.goto("http://127.0.0.1:4193/berita/indek-kepuasan-masyarakat-triwuln-ke-ii-tahun-2026", { waitUntil: "networkidle2", timeout: 30000 });
await new Promise((r) => setTimeout(r, 2000));
console.log("title:", await p.title());
console.log("h1 class:", await p.evaluate(() => document.querySelector("h1")?.className));
await b.close();
preview.kill();
process.exit(0);
