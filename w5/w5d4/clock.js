class Clock {
  constructor() {
    const d = new Date;
    this.hours = d.getHours();
    this.minutes = d.getMinutes();
    this.seconds = d.getSeconds();
    // 1. Create a Date object.
    // 2. Store the hours, minutes, and seconds.
    // 3. Call printTime.
    // 4. Schedule the tick at 1 second intervals.
    this.printTime();
    global.setInterval(this._tick.bind(this), 1000);
  }

  printTime() {
    // Format the time in HH:MM:SS
    // Use console.log to print it.
    let renderTime = function(int) {
      if (int < 10) return `0${int}` ;
      else return int;
    };
    console.log(`${renderTime(this.hours)}:${renderTime(this.minutes)}:${renderTime(this.seconds)}`);
  }

  _tick() {
    // 1. Increment the time by one second.
    // 2. Call printTime.
    this.seconds += 1;
    if (this.seconds === 60) {
      this.minutes += 1;
      this.seconds = 0;
    }
    if (this.minutes === 60){
      this.hours += 1;
      this.minutes = 60;
    }
    if (this.hours === 24){
      this.seconds = 0;
      this.minutes = 0;
      this.hours = 0;
    }
    // console.log(this);
    this.printTime();
  }
}

const clock = new Clock();
// clock.printTime();
