import React from 'react';

const Post = ({post}) =>
  <div className="post_container" key={post.id}>
    <p class="post_message">{post.message}</p>
    <p class="post_time">{post.created_at}</p>
    <p class="post_by">{post.customer_id}</p>
  </div>



  export default Post;
