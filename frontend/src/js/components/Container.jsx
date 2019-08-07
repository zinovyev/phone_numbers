import React, { Component } from "react";
import ReactDOM from "react-dom";
import axios from 'axios';
import Input from "./Input.jsx";
import Button from "./Button.jsx";
import Entries from "./Entries.jsx";
import Pagination from "./Pagination.jsx";

class Container extends Component {
  constructor() {
    super();

    this.state = {
      input: "",
      pagesCount: 0,
      entries: [],
      searchQueryParams: {},
    };

    this.handleSearchClick = this.handleSearchClick.bind(this);
    this.handlePageClick = this.handlePageClick.bind(this);
    this.handleChange = this.handleChange.bind(this);
    this.getDataAxios = this.getDataAxios.bind(this);
  }

  handleChange(e) {
    this.setState({ input: e.target.value });
  }

  handleSearchClick(e) {
    if (this.state.input != undefined && this.state.input.length > 0) {
      var searchQueryParams = { search: this.state.input }
      this.setState({ searchQueryParams: searchQueryParams }, () => {
        this.getDataAxios();
      });
    }
  }

  handlePageClick(e, pageNum = 1) {
    if (this.state.input != undefined && this.state.input.length > 0) {
      var searchQueryParams = { search: this.state.input, page: pageNum }
      this.setState({ searchQueryParams: searchQueryParams }, () => {
        this.getDataAxios();
      });
    }
  }

  getDataAxios() {
    axios.get('http://0.0.0.0:3000/api/v1/number_plan_entries', { params: this.state.searchQueryParams })
         .then(res => {
           const entries = res.data.data;
           const pagesCount = res.data.count;
           this.setState((state, props) => ({ entries: entries, pagesCount: pagesCount }));
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
                <Button handleClick={this.handleSearchClick} />
              </div>
            </div>
          </div>
        </form>
        <Entries entries={this.state.entries} />
        <Pagination pagesCount={this.state.pagesCount} handleClick={this.handlePageClick} />
      </div>
    );
  }
}

const wrapper = document.getElementById("create-search-form");
wrapper ? ReactDOM.render(<Container />, wrapper) : false;

export default Container;
