import React from 'react';

const Post = ({post}) =>
  <div className="single-post" key={post.id}>
    <p>{post.message}</p>
    <p>{post.created_at}</p>
    <p>{post.customer_id}</p>
  </div>



  export default Post;
