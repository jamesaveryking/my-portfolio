import React from 'react';
import ReactDOM from 'react-dom';
import ExampleWork from './example-work.js';

const myWork = [
  {
    'title': "Coding Examples",
    'image': {
      'desc': "Coding Example Image From A Cloud Guru",
      'src': "images/example1.png",
      'comment':""
    }
  },
  {
    'title': "Publications",
    'image': {
      'desc': "Blurred Image of an Essay",
      'src': "images/Research.jpg",
      'comment':""
    }
  },
  {
    'title': "Miscellaneous",
    'image': {
      'desc': "K10 complete graph",
      'src': "images/k10.png",
      'comment':""
    }
  }
];
ReactDOM.render(<ExampleWork work = {myWork}/>, document.getElementById('example-work'));
