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
    fetch('http://localhost:3001/posts')
    .then(response => response.json())
    .then(data => this.setState({ posts: data.posts }));
  }
  render() {
    const { posts } = this.state;
    return (
      <div className="Posts-container">
        <p className="it_block">it <mark className="green">"allows user to see all posts"</mark> <mark className="purple">do</mark></p>

        {posts.map( post => {
          return (<Post post={post} key={post.id} />)
        })}

      </div>
    )
  }
}


export default PostsContainer;
