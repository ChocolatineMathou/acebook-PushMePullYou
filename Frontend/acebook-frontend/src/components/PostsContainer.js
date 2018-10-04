import React, { Component } from 'react';
import Post from './Post';

class PostsContainer extends Component {

  constructor(props){
    super(props)
    this.state = {
      posts: []
    }
  }


  componentDidMount() {
    fetch('/posts')
    .then(response => response.json())
    .then(data => this.setState({ posts: data.posts }));
  }





  render() {
    return (
      <div className="Posts-container">
        {this.state.posts.map( post => {
          return (<Post post={post} key={post.id} />)
        })}

      </div>
    )
  }
}


export default PostsContainer;
