import React, { Component } from "react";
import ReactDOM from "react-dom";
import axios from 'axios';
import Input from "./Input.jsx";
import Button from "./Button.jsx";
import Entries from "./Entries.jsx";

class Container extends Component {
  constructor() {
    super();

    this.state = {
      input: "",
      entries: [],
    };

    this.handleClick = this.handleClick.bind(this);
    this.handleChange = this.handleChange.bind(this);
    this.getDataAxios = this.getDataAxios.bind(this);
  }

  handleChange(event) {
    this.setState({ input: event.target.value });
  }

  handleClick(event) {
    if (this.state.input != undefined && this.state.input.length > 0) {
      this.getDataAxios(this.state.input);
      console.log(this.state);
    }
  }

  getDataAxios(searchRequest) {
    axios.get('http://0.0.0.0:3000/api/v1/number_plan_entries', { params: { search: searchRequest } })
        .then(res => {
          const entries = res.data;
          this.setState({ entries: entries });
        });
  }

  render() {
    const { seo_title } = this.state;
    return (
      <div>
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
        <Entries entries={this.state.entries}/>
      </div>
    );
  }
}

const wrapper = document.getElementById("create-search-form");
wrapper ? ReactDOM.render(<Container />, wrapper) : false;

export default Container;
