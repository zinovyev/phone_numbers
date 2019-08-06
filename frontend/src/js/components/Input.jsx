import React, { Component } from "react";
import ReactDOM from "react-dom";

class Input extends Component {
  constructor(props) {
    super(props);
  }

  render() {
    const handleChange = this.props.handleChange;
    return (
      <input type="text"
             className="form-control"
             placeholder="Phone number"
             aria-label="Phone number"
             aria-describedby="button-addon2"
             onChange={handleChange} />
    );
  }
} 

export default Input;
