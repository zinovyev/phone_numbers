import React, { Component } from "react";
import ReactDOM from "react-dom";

class Entries extends Component {
  constructor(props) {
    super(props);
  }

  printEntry(entry, i) {
    let entryText = entry.prefix;
    entryText += entry.comment ? ` (${entry.comment})` : ''
    return <li className="list-group-item" key={i}>{entryText}</li>
  }

  render() {
    const entries = this.props.entries;
    return (
      <ul className="list-group">
        {entries.map(this.printEntry)}
      </ul>
    );
  }
}

export default Entries;
