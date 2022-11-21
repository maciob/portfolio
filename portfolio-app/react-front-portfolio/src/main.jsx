import { render } from "react-dom";
import {
  BrowserRouter,
  Routes,
  Route,
} from "react-router-dom";
import App from "./App";
import AddBook from "./pages/AddBook";
import BookList from "./pages/BookList";
import EditBook from "./pages/EditBook";
const rootElement = document.getElementById("root");
render(
  <BrowserRouter>
    <Routes>
      <Route path="/" element={<App />} />
      <Route path="/AddBook" element={<AddBook />} />
      <Route path="/EditBook/:id/:author/:title/:year" element={<EditBook />} />
      <Route path="/BookList" element={<BookList />} />
    </Routes>
  </BrowserRouter>,
  rootElement
);
