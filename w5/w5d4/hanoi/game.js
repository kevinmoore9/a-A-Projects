const readline = require('readline');

const reader = readline.createInterface({
  input: process.stdin,
  output: process.stdout
});

class HanoiGame {
  constructor(numStacks) {
    this.numStacks = numStacks;
    this.stacks = Array(numStacks);
    for(let i = 0; i < numStacks; i++) {
      this.stacks[i] = [];
      this.stacks[0].push(numStacks - i);
    }
  }


  promptMove(callback) {
    let startTowerIdx;
    let endTowerIdx;
    console.log(this.stacks);
    reader.question("Which stack do you want to move from?\n", (res1) => {
      startTowerIdx = parseInt(res1);
      reader.question("Where would you like to move to?\n", (res2) => {
      endTowerIdx =  parseInt(res2);
      callback(startTowerIdx, endTowerIdx);
      });
    });
  }

  isValidMove(start, finish) {
    let startStack = this.stacks[start];
    let endStack = this.stacks[finish];

    if (start < 0 || finish < 0 || start > this.stacks.length -1 || finish > this.stacks.length -1) return false;
    if (startStack.length === 0) return false;
    else if (startStack[startStack.length -1] > endStack[endStack.length -1]) return false;
    else return true;
  }

  move(start, finish) {
    console.log(start);
    if(this.isValidMove(start,finish)) {
      this.stacks[finish].push(this.stacks[start].pop());
      return true;
    }
    console.log("Bad move");
    return false;
  }

  isWon() {
    for(let i=1; i < this.numStacks -1; i++) {
      if (this.stacks[i].length === this.numStacks) return true;
    }
    return false;
  }

  run(completionCallback) {
    this.promptMove((start, finish) => {
      this.move(start, finish);
      if (this.isWon() === false) {
        this.run(completionCallback);
      } else {
        console.log("you won!!!!!!");
        completionCallback();
      }
    });
  }
}

const game = new HanoiGame(3);
game.run(() => reader.close());



// game.promptMove( function(start, finish) {
//    console.log(game.move(start, finish));
//  });
