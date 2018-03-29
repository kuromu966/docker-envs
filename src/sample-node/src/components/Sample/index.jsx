import React from 'react';
import PropTypes from 'prop-types';
import Loadable from 'react-loading-overlay';
import moment from 'moment';

export default class Sample extends React.Component {
  constructor(props) {
    super(props);
    this.state = {};
  }
  _header(){
    return (
      <thead>
        <tr>
	  <td><strong>Date</strong></td>
	  <td><strong>From</strong></td>
	  <td><strong>To</strong></td>
	  <td><strong>Protocol</strong></td>
	  <td><strong>Score</strong></td>
        </tr>
      </thead>
    );
  }
  _recordLine(id,x){
    let y = x.type.split(':');
    let score = y[0];
    let uuid = y[1];
    return (
      <tr key={`sandbox_index_${id}`}>
        <td>{x.date}</td>
        <td>{x.fromaddr}</td>
        <td>{x.toaddr}</td>
        <td>{x.proto}</td>
        <td>{score}</td>
      </tr>
    );
  }
  _recordsList(){
    let list = [];
    let num = 0;
    for(let x of this.props.data){
      list.push(this._recordLine(num,x));
      num++;
    }
    return (<tbody>{list}</tbody>);
  }
  render() {
    return (
      <div>
        <Loadable active={this.props.loading} spinner animate={true} text='Loading content...'>
          <div className="box box-info" style={{minHeight:200}}>
            <div className="box-body table-responsive">
	      <table className="table table-hover" style={{wordWrap: 'break-word'}}>
                {this._header()}
                {this._recordsList()}
	      </table>
            </div>
          </div>
        </Loadable>
      </div>
    );
  }
}

Sample.propTypes = {
  data: PropTypes.array,
  loading: PropTypes.bool,
  startdate: PropTypes.string,
  enddate: PropTypes.string,
  update: PropTypes.func,
};

Sample.defaultProps = {
  data: [],
  loading: false,
  startdate: '',
  enddate: '2018/1/30',
  update: (start,end)=>{if(process.env.NODE_ENV !== 'production') console.log(`Start:${start} End:${end}`);},
};


