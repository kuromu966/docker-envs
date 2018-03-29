import React from 'react';
import { storiesOf } from '@storybook/react';
import { action } from '@storybook/addon-actions';
import Sample from './';

const STARTDATE = '2018/1/1';
const ENDDATE = '2018/1/30';
const URL = "http://localhost";
const DATA = [
  {
    'sp' : 0,
    'proto' : 'SMTP',
    'dp' : 0,
    'date' : '2017-12-14 18:43:43+09',
    'status' : 'Block(Infected,Modified,Unscannable)',
    'fromaddr' : 'tester1@gmail.com',
    'da' : '39.110.239.102',
    'toaddr' : 'tester1@gmail.com',
    'dir' : 'in',
    'comment' : '',
    'sa' : '192.168.101.54',
    'type' : '90:6074db4b44da001016567530797ce766'
  },
  {
    'sp' : 0,
    'proto' : 'SMTP',
    'dp' : 0,
    'date' : '2017-12-14 18:44:46+09',
    'status' : 'Block(Infected,Modified,Unscannable)',
    'fromaddr' : 'tester1@gmail.com',
    'da' : '39.110.239.102',
    'toaddr' : 'tester1@gmail.com',
    'dir' : 'in',
    'comment' : '',
    'sa' : '192.168.101.54',
    'type' : '90:6074db4b44da001016567530797ce766'
  },
  {
    'sp' : 0,
    'proto' : 'SMTP',
    'dp' : 0,
    'date' : '2017-12-15 12:44:45+09',
    'status' : 'Block(Infected,Modified,Unscannable)',
    'fromaddr' : 'tester1from@gmail.com',
    'da' : '39.110.239.102',
    'toaddr' : 'tester1@gmail.com',
    'dir' : 'in',
    'comment' : '',
    'sa' : '192.168.101.54',
    'type' : '90:6074db4b44da001016567530797ce766'
  }
];

storiesOf('Table.Sample', module)
  .addDecorator((story) => (
    <div id="sample">
        { story() }
    </div>
  ))
  .add('default', () => (
    <Sample update={action('update')} />
  ))
  .add('loading = true', () => (
    <Sample update={action('update')} loading={true} />
  ))
  .add('set values', () => (
    <Sample data={DATA} update={action('update')} />
  ))
  .add('set values, url and date', () => (
    <Sample data={DATA} update={action('update')} startdate={STARTDATE} enddate={ENDDATE} />
  ))  .add('set values and loading', () => (
    <Sample data={DATA} update={action('update')} loading={true} startdate={STARTDATE} enddate={ENDDATE} />
  ));



