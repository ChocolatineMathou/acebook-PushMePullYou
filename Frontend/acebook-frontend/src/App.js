import React, { Component } from 'react';
import './App.css';
import PostsContainer from './components/PostsContainer';
import PostForm from './components/PostForm';




class App extends Component {
  render() {
    return (
      <div className="App">
        <h1><mark className="yellow">PushMePullYou</mark>.acebook <mark className="purple">do</mark></h1>
        <PostForm />
        <PostsContainer />

        <h1 className="end"><mark className="purple">end</mark></h1>
      </div>
    );
  }
}

export default App;
