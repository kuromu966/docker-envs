export default function now() {
  const now = new Date();
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
  return `${y}/${m}/${d} ${h}:${min}:${s}`;
}
