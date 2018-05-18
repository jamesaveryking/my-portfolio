import React from 'react';
import { shallow } from 'enzyme';
import ExampleWork, { ExampleWorkBubble } from '../js/example-work';


import Enzyme from 'enzyme';
import Adapter from 'enzyme-adapter-react-16';
Enzyme.configure({adapter: new Adapter()});

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

describe("ExampleWork component", () => {
  let component = shallow(<ExampleWork work={myWork} />);
  it("Should be a 'section' element", () => {
      expect(component.type()).toEqual('section');
  });
  it("Should contain as many children as there are working examples", ()=>{
    expect(component.find("ExampleWorkBubble").length).toEqual(myWork.length);
  })
})

describe("ExampleWorkBubble component", () => {
  let component = shallow(<ExampleWorkBubble example={myWork[1]}/>);

  let images = component.find("img");

  it("Should contain a single 'img' element",()=>{
    expect(images.length).toEqual(1);
  });

  it("Should have the image src set correctly", ()=>{
    expect(images.prop('src')).toEqual(myWork[1].image.src);
  });
})
