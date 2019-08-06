import React, { Component } from "react";
import ReactDOM from "react-dom";

class Button extends Component {
  constructor(props) {
    super(props);
  }

  render() {
    const handleClick = this.props.handleClick;
    return (
      <button className="btn btn-outline-secondary"
              type="button"
              id="button-addon2"
              onClick={handleClick}
      >Search</button>
    )
  }
}

export default Button;
