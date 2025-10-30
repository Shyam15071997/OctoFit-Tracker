import React, { useEffect, useState } from 'react';
import { Link } from 'react-router-dom';
import apiClient from '../api/apiClient';

const Team: React.FC = () => {
    const [teams, setTeams] = useState([]);
    const [loading, setLoading] = useState(true);

    useEffect(() => {
        const fetchTeams = async () => {
            try {
                const response = await apiClient.get('/teams/');
                setTeams(response.data);
            } catch (error) {
                console.error('Error fetching teams:', error);
            } finally {
                setLoading(false);
            }
        };

        fetchTeams();
    }, []);

    if (loading) {
        return <div>Loading...</div>;
    }

    return (
        <div>
            <h1>Team Management</h1>
            <Link to="/create-team">Create New Team</Link>
            <ul>
                {teams.map((team) => (
                    <li key={team.id}>
                        <h2>{team.name}</h2>
                        <p>Members: {team.members.length}</p>
                    </li>
                ))}
            </ul>
        </div>
    );
};

export default Team;