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
        <p class="it_block">it <mark class="green">"allows user to see all posts"</mark> <mark class="purple">do</mark></p>

        {this.state.posts.map( post => {
          return (<Post post={post} key={post.id} />)
        })}
        
      </div>
    )
  }
}


export default PostsContainer;
