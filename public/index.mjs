import { html, render } from './preact.js'


// const wsUrl = `${import.meta.url.replace("http", "ws")}/ws`
// const ws = new WebSocket(wsUrl);


function App(props) {
    return html`
    <div>
    ${props.cpus.map((cpu) => {
        return html`<div class="bar">
            <div class="bar-inner" style="width: ${cpu}">
            <span class="label">${cpu.toFixed(2)}% usage</span>
            </div>
        </div>`;
    })}
    </div>`;
}

// let update = async () => {
//     let response = await fetch("/api/cpus");
//     if (response.status !== 200) {
//         throw new Error(`HTTP error! status ${response.status}`);
//     }
//     let json = await response.json();

//     render(html`<${App} cpus=${json} />`, document.getElementById('main'))
// };
// setInterval(update, 1000);

let url = new URL("/realtime/cpus", window.location.href);
url.protocol = url.protocol.replace("http", "ws");
console.log(`ws url: ${url}`)

let ws = new WebSocket(url.href);
ws.onmessage = (ev) => {
    let json = JSON.parse(ev.data);
    render(html`<${App} cpus=${json} />`, document.getElementById('main'))
};