import { call, put } from 'redux-saga/effects';
import CSRFToken from './csrftoken';

function _postJSON(url,params){
  return fetch(
    url,
    {
      method: 'POST',
      body: JSON.stringify(params),
      mode: 'same-origin',
      credentials: 'include',
      headers: {
        'Accept': 'application/json',
        'Content-Type': 'application/json',
        'X-CSRF-TOKEN': CSRFToken(),
      }
    })
    .then(res => {
      if(res.ok){
        return res.json();
      }else{
        throw new Error(`Failed to fetch "${res.url}". ${res.status} ${res.statusText}`);
      }
    })
    .then(payload => ([payload, undefined]))
    .catch(error => ([{state:0, logs:[]}, error.message]));
}


export default function* postJSON(url,params){
  const [payload,error] = yield call(_postJSON,url,params);
  let result = {payload, error};
  if(process.env.NODE_ENV !== 'production'){
    if(payload && error === undefined){
      yield put({type: 'JSON_FETCH_SUCCEEDED', response:result});
    }else{
      yield put({type: 'JSON_FETCH_FAILED', response:result});
    }
  }
  return result;
}
