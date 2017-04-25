import React from 'react';
import ReactDOM from 'react-dom';




class Root extends React.Component {
  constructor(props) {
    super(props);

    const d = new Date;
    this.state = {
      hour: d.getHours(),
      minutes: d.getMinutes(),
      seconds: d.getSeconds()
    }
    setInterval(() => this.tick(this.state.hour, this.state.minutes, this.state.seconds), 1000)
  }

  tick(hours, minutes, seconds) {
    seconds += 1;
    if (seconds === 60) {
      seconds = 0;
      minutes += 1;
      if (minutes === 60) {
        minutes == 0;
        hours += 1;
        if (hours === 24) {
          hours = 0;
        }
      }
    }
    this.setState({
      hour: hours,
      minutes: minutes,
      seconds: seconds
    })
    console.log(`${this.state.hour}:${this.state.minutes}:${this.state.seconds}`);
  }

  pad(n) {
    if (n < 10) {
      return `0${n}`
    }
    return n;
  }

  render() {
    let newHours;
    let dayTime;

    if (this.state.hour > 12) {
      dayTime = 'PM';
      newHours = this.state.hour - 12;
    } else {
      dayTime = 'AM'
      newHours = this.state.hour;
    }



    return(
      <div>
        <h1>{this.pad(newHours)}:{this.pad(this.state.minutes)}:{this.pad(this.state.seconds)} {dayTime}</h1>
      </div>
    );
  }
}

document.addEventListener('DOMContentLoaded', () => {
  ReactDOM.render(<Root/>, document.getElementById('main'));
});
