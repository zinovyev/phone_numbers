import React, { Component } from "react";
import ReactDOM from "react-dom";

class Pagination extends Component {
  constructor(props) {
    super(props);
  }

  printPages(pagesCount) {
    const handleClick = this.props.handleClick;
    const items = [];
    for (let i = 0; i < pagesCount; ++i) {
      let pageNum = i + 1;
      items.push(
        <button type="button"
                className="btn btn-secondary"
                key={i}
                onClick={(e) => { handleClick(e, pageNum) }}>{pageNum}</button>
      );
    }
    return items;
  }

  render() {
    const pagesCount = this.props.pagesCount;
    return (
      <div className="btn-toolbar" role="toolbar" aria-label="Toolbar with button groups">
        <div className="btn-group mr-2" role="group" aria-label="First group">
          {this.printPages(pagesCount)}
        </div>
      </div>
    );
  }
}

export default Pagination;
