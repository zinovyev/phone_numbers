import React, { Component } from "react";
import ReactDOM from "react-dom";
import Input from "./Input.jsx";
import Button from "./Button.jsx";

class Container extends Component {
  constructor() {
    super();

    this.state = {
      input: "",
    };

    this.handleClick = this.handleClick.bind(this);
    this.handleChange = this.handleChange.bind(this);
  }

  handleChange(event) {
    this.setState({ input: event.target.value });
  }

  handleClick(event) {
    if (this.state.input != undefined && this.state.input.length > 0) {
      console.log(this.state.input);
    }
  }

  render() {
    const { seo_title } = this.state;
    return (
      <form>
        <div className="form-group">
          <div className="input-group mb-3">
            <div className="input-group-append">
              <Input handleChange={this.handleChange} />
              <Button handleClick={this.handleClick} /> 
            </div>
          </div>
        </div>
      </form>
    );
  }
}

const wrapper = document.getElementById("create-search-form");
wrapper ? ReactDOM.render(<Container />, wrapper) : false;

export default Container;
