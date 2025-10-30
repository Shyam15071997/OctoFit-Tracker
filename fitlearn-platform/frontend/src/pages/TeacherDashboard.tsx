import React, { useEffect, useState } from 'react';
import { fetchTeacherData } from '../api/apiClient';

const TeacherDashboard: React.FC = () => {
    const [teacherData, setTeacherData] = useState(null);
    const [loading, setLoading] = useState(true);
    const [error, setError] = useState('');

    useEffect(() => {
        const getTeacherData = async () => {
            try {
                const data = await fetchTeacherData();
                setTeacherData(data);
            } catch (err) {
                setError('Failed to fetch teacher data');
            } finally {
                setLoading(false);
            }
        };

        getTeacherData();
    }, []);

    if (loading) {
        return <div>Loading...</div>;
    }

    if (error) {
        return <div>{error}</div>;
    }

    return (
        <div>
            <h1>Teacher Dashboard</h1>
            {teacherData && (
                <div>
                    <h2>Welcome, {teacherData.name}</h2>
                    <h3>Your Classes</h3>
                    <ul>
                        {teacherData.classes.map((classItem: any) => (
                            <li key={classItem.id}>{classItem.name}</li>
                        ))}
                    </ul>
                    <h3>Monthly Challenges</h3>
                    <ul>
                        {teacherData.challenges.map((challenge: any) => (
                            <li key={challenge.id}>{challenge.title}</li>
                        ))}
                    </ul>
                </div>
            )}
        </div>
    );
};

export default TeacherDashboard;