import React from 'react';
import ReactDOM from 'react-dom';
import { createStore, applyMiddleware, compose } from 'redux';
import { Provider, connect } from 'react-redux';
import createSagaMiddleware from 'redux-saga';
import { fork, call, put, takeEvery } from 'redux-saga/effects';
import getJSON from '/util/getJSON';
import Sample from '/components/Sample';
import { isDebugBrowser } from '/util/checkBrowser';
import moment from 'moment';

const INIT_STARTDATE = moment().startOf('month');
const INIT_ENDDATE = moment().endOf('month');

////////////////////////////////////////////////////////////////////////
// Tasks

function* _reload(action){
  const startdate = action.params.start.format('YYYY-MM-DD');
  const enddate = action.params.end.format('YYYY-MM-DD');
  const url = `/api/v1/test?startdate=${startdate}&enddate=${enddate}`;
  const res = yield call(getJSON,url);
  res.type = 'UPDATE_DATA';
  if(res.payload){
    yield put(res);
    yield put({type:'UPDATE_DATE',startdate:startdate,enddate:enddate});
  }else{
    if(process.env.NODE_ENV !== 'production'){
      console.log(`Invalid response from ${url}`);
      console.log(res);
    }
  }
}

function* reload(action){
  yield put({type:'SET_ENABLE_LOADING'});
  if(action) yield call(_reload,action);
  yield put({type:'SET_DISABLE_LOADING'});
}

function* Saga() {
  yield fork(reload,{params:{start:INIT_STARTDATE,end:INIT_ENDDATE}});
  yield takeEvery('TASK_RELOAD', reload);
}


function reducer(state={}, action) {
  switch (action.type) {
    case 'UPDATE_DATA':{
      let newer = Object.assign({}, state);
      newer.data = action.payload;
      return newer;
    }
    case 'UPDATE_DATE':{
      let newer = Object.assign({}, state);
      newer.startdate = action.startdate;
      newer.enddate = action.enddate;
      return newer;
    }
    case 'SET_ENABLE_LOADING':{
      let newer = Object.assign({}, state);
      newer.loading = true;
      return newer;
    }
    case 'SET_DISABLE_LOADING':{
      let newer = Object.assign({}, state);
      newer.loading = false;
      return newer;
    }
    default:{
      return state;
    }
  }
}

////////////////////////////////////////////////////////////////////////
// Containter
let initialState = {
  data: [],
  loading: false,
  startdate: INIT_STARTDATE.format('YYYY-MM-DD'),
  enddate: INIT_ENDDATE.format('YYYY-MM-DD'),
};

let mapStateToProps = (state) => {
  return {
    data: state.data,
    loading: state.loading,
    startdate: state.startdate,
    enddate: state.enddate,
  };
};

let mapDispatchToProps = (dispatch) => {
  return {
    update(startdate,enddate){
      dispatch({
        type:'TASK_RELOAD',
        params:{
	  start:startdate,
	  end:enddate,
        },
      });
    },
  };
};

const Container = connect(mapStateToProps,mapDispatchToProps)(Sample);


////////////////////////////////////////////////////////////////////////
// Store
let sagaMiddleware = createSagaMiddleware();
let middleware = compose(applyMiddleware(sagaMiddleware));
if(process.env.NODE_ENV !== 'production'){
  if(isDebugBrowser()){
    middleware = compose(
      applyMiddleware(sagaMiddleware),
      window.__REDUX_DEVTOOLS_EXTENSION__ && window.__REDUX_DEVTOOLS_EXTENSION__({name:'React Sample'})
    );
  }
}
let store = createStore(reducer, initialState, middleware);
sagaMiddleware.run(Saga);


////////////////////////////////////////////////////////////////////////
// Rendering
ReactDOM.render(
  (
    <Provider store={store}><Container /></Provider>
  ),
  document.querySelector('div#sample')
);
