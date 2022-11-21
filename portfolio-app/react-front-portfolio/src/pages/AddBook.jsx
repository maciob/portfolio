import React from 'react';
import Header from "../components/Header";
import NavBar from '../components/NavBar';
class AddBook extends React.Component {
    handleSubmit = (event) => {
        event.preventDefault()
        console.log(event.target.elements.Title.value)
        console.log(event.target.elements.Author.value)
        console.log(event.target.elements.Year.value)
        const requestOptions = {
            method: 'POST',
            headers: { 'Content-Type': 'application/json' },
            body: JSON.stringify({ Title: event.target.elements.Title.value, Author: event.target.elements.Author.value, Year: event.target.elements.Year.value })
        };
        fetch('/api', requestOptions)
            .then(response => response.json())
    }
    render() {
        return (
            <div className="ui celled list">
                <Header />
                <br />
                <br />
                <NavBar />
                <h2>Add Book</h2>
                <form className="ui form" onSubmit={this.handleSubmit}>
                    <div className="field">
                        <label>Title</label>
                        <input type="text" name="Title" placeholder="Title" />
                    </div>
                    <div className="field">
                        <label>Author</label>
                        <input type="text" name="Author" placeholder="Author" />
                    </div>
                    <div className="field">
                        <label>Year</label>
                        <input type="number" name="Year" placeholder="Year" />
                    </div>
                    <button className="ui button blue">Add</button>
                </form>
            </div>
        );
    }
}

export default AddBook;