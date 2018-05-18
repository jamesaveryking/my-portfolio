import React from 'react';
import { shallow } from 'enzyme';
import ExampleWorkModal from '../js/example-work-modal';


import Enzyme from 'enzyme';
import Adapter from 'enzyme-adapter-react-16';
Enzyme.configure({adapter: new Adapter()});


describe("ExampleWorkModal component", ()=>{
  let component = shallow(<ExampleWorkModal />);

  let anchors = component.find("a");

  if("Should contain a sinlge 'a' element", ()=>{
    expect(anchors.length).toEqual(1);
  });
});
