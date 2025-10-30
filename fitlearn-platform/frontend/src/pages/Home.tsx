import React from 'react';
import { Link } from 'react-router-dom';

const Home: React.FC = () => {
    return (
        <div className="home">
            <h1>Welcome to FitLearn</h1>
            <p>Your journey to fitness starts here!</p>
            <div className="features">
                <h2>Features</h2>
                <ul>
                    <li><Link to="/register">Register</Link> to create your profile</li>
                    <li><Link to="/login">Login</Link> to access your dashboard</li>
                    <li>Log your workouts and track your progress</li>
                    <li>Join teams and participate in challenges</li>
                    <li>Check out the leaderboard to see how you stack up!</li>
                </ul>
            </div>
        </div>
    );
};

export default Home;