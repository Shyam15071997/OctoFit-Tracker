import React from 'react';
import { BrowserRouter as Router, Route, Switch } from 'react-router-dom';
import Home from '../pages/Home';
import Items from '../pages/Items';
import Header from '../components/Header';
import Footer from '../components/Footer';

const AppRoutes = () => {
    return (
        <Router>
            <Header />
            <Switch>
                <Route exact path="/" component={Home} />
                <Route path="/items" component={Items} />
            </Switch>
            <Footer />
        </Router>
    );
};

export default AppRoutes;