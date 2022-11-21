import React from 'react';
import Header from "../components/Header";
import NavBar from '../components/NavBar';

class EditBook extends React.Component {

    handleSubmit = (event) => {
        event.preventDefault()
        console.log(event.target.elements.ID.value)
        console.log(event.target.elements.Title.value)
        console.log(event.target.elements.Author.value)
        console.log(event.target.elements.Year.value)
        let basic = "/api"
        let path = basic.concat("/",event.target.elements.ID.value)
        console.log(path)
        const requestOptions = {
            method: 'PUT',
            headers: { 'Content-Type': 'application/json' },
            body: JSON.stringify({ Title: event.target.elements.Title.value, Author: event.target.elements.Author.value, Year: event.target.elements.Year.value })
        };
        fetch(path, requestOptions)
            .then(response => response.json())
    }

    render() {
        
        const id = window.location.href.split('/')[4]
        const title = window.location.href.split('/')[6]
        const author = window.location.href.split('/')[5]
        const year = window.location.href.split('/')[7]
        
        return (
            <div className="ui celled list">
                <Header />
                <br />
                <br />
                <NavBar />
                <h2>Edit Book</h2>
                <form className="ui form" onSubmit= {this.handleSubmit}>
                    <div className="field">
                        <label>ID</label>
                        <input disabled={true} type="text" name="ID" placeholder="ID" value={id} />
                    </div>
                    <div className="field">
                        <label>Title</label>
                        <input type="text" name="Title" placeholder="Title" defaultValue={title} />
                    </div>
                    <div className="field">
                        <label>Author</label>
                        <input type="text" name="Author" placeholder="Author" defaultValue={author} />
                    </div>
                    <div className="field">
                        <label>Year</label>
                        <input type="number" name="Year" placeholder="Year" defaultValue={year} />
                    </div>
                    <button className="ui button blue">Edit</button>
                </form>
            </div>
        );
    }
}

export default EditBook;