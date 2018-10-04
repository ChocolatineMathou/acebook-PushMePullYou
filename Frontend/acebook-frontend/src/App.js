import React, { Component } from 'react';
import './App.css';
import PostsContainer from './components/PostsContainer';




class App extends Component {
  render() {
    return (
      <div className="App">
        <header className="App-header">
          Acebook PushMePullYou Posts

        </header>
        <h1><mark class="yellow">PushMePullYou</mark>.acebook <mark class="purple">do</mark></h1>

        <PostsContainer />

        <h1 class="end"><mark class="purple">end</mark></h1>
      </div>
    );
  }
}

export default App;
