import React from 'react';

class Post extends React.Component {
  render() {
    const message = this.props.post.message
    const first_name = this.props.post.first_name
    const last_name = this.props.post.last_name
    const date = new Date(this.props.post.created_at);
    const formattedDate = new Intl.DateTimeFormat('en-Gb', {
      hour: '2-digit',
      minute: '2-digit',
      day: '2-digit',
      month: '2-digit',
      year: '2-digit'
    }).format(date)

    return (
      <div className="post_container">
      <p className="post_message">{message}</p>
      <p className="post_time">{formattedDate}</p>
      <p className="post_by">{first_name} {last_name}</p>
      </div>
    )
  }
}

  export default Post;
