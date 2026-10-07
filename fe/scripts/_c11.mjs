import { spawn } from "node:child_process";
import puppeteer from "puppeteer-core";

const preview = spawn(process.execPath, ["node_modules/vite/bin/vite.js", "preview", "--port", "4192", "--strictPort"], { stdio: "ignore" });
await new Promise((r) => setTimeout(r, 2500));
const b = await puppeteer.launch({ executablePath: "C:\\Program Files\\Google\\Chrome\\Application\\chrome.exe", headless: "new", args: ["--no-sandbox"] });
const p = await b.newPage();
await p.goto("http://127.0.0.1:4192/berita/indek-kepuasan-masyarakat-triwuln-ke-ii-tahun-2026", { waitUntil: "networkidle2", timeout: 30000 });
await new Promise((r) => setTimeout(r, 2000));
console.log("title:", await p.title());
console.log("h1 class:", await p.evaluate(() => document.querySelector("h1")?.className));
console.log("api:", await p.evaluate(async () => {
  const r = await fetch("/api/articles/indek-kepuasan-masyarakat-triwuln-ke-ii-tahun-2026");
  return r.status;
}));
console.log("news-detail-title:", await p.evaluate(() => !!document.querySelector(".news-detail-title")));
console.log("hero:", await p.evaluate(() => !!document.querySelector(".hero, [class*=hero]")));
await b.close();
preview.kill();
process.exit(0);
