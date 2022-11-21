import React from "react";
import Header from "../components/Header";
import NavBar from "../components/NavBar";
import { Link } from "react-router-dom";

class BookList extends React.Component {

    constructor() {
        super();
        this.state = {
            books:[],
            active: false
        };
    }

    toggleClass() {
        const currentState = this.state.active;
        this.setState({ active: !currentState });
    };


    componentDidMount() {

        fetch("/api")
            .then(result => result.json())
            .then(books => this.setState({books})).catch(error => console.log(error))
    }

    render () {
        function handleDeleteClick( id ) {
            let basic = "/api"
            let path = basic.concat("/",id)
            
            const requestOptions = {
                method: 'DELETE',
                headers: { 'Content-Type': 'application/json'},
            };
            fetch(path, requestOptions)
                .then(response => response.json())
                .then(data => this.setState({ postId: data.id }));
        }
        
        return (
            <div className="ui celled list"> 
                <Header />
                <br />
                <br />                
                <NavBar />
                {this.state.books.map(
                    book => 
                       <div className="item" key={book._id}>
                            <br/>
                            <div className="content">
                                <div className="header">{book._id}</div>
                                <br/>
                                <div> {book.Author}</div>
                                <div> {book.Title}</div>
                                <div> {book.Year}</div>
                            </div>
                            <br/>
                            <Link className="ui icon button" component={Link} to={`/EditBook/${book._id}/${book.Author}/${book.Title}/${book.Year}`}>
                                <i className="edit icon alternate right" style={{color:"red"}}></i>
                            </Link>
                            <button className="ui icon button" onClick = {() => handleDeleteClick(book._id)}>
                                <i className="trash icon alternate right" style={{color:"red"}}></i>
                            </button>      
                            <br/>                    
                       </div>
                )}
            </div>
        );
    }
}

export default BookList;