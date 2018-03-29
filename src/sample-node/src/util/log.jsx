export function makeLogMessage(facility,msg){
  return [Math.floor(Date.now()/1000),facility,msg];
}

export function getLogLines(items){
  return items.map((log) => {
    const now = new Date(log[0]*1000);
    let y = now.getFullYear();
    let m = now.getMonth() + 1;
    let d = now.getDate();
    let h = now.getHours();
    let min = now.getMinutes();
    let s = now.getSeconds();
    if (m < 10) m = `0${m}`;
    if (d < 10) d = `0${d}`;
    if (h < 10) h = `0${d}`;
    if (min < 10) min = `0${min}`;
    if (s < 10) s = `0${s}`;
    return `${y}/${m}/${d} ${h}:${min}:${s} [${log[1].toUpperCase()}] ${log[2]}`;
  });
}

