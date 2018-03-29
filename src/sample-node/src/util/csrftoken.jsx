export default function CSRFToken(){
  return document.querySelector('div.wrapper input[name="csrf_token"]').value;
}
