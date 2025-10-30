import React, {useEffect, useState} from "react";
export default function Leaderboard(){
  const [profiles, setProfiles] = useState([]);
  useEffect(()=> {
    fetch("/api/profiles/").then(r=>r.json()).then(setProfiles).catch(()=>{});
  },[])
  return (
    <div style={{padding:20}}>
      <h2>Leaderboard</h2>
      <ul>
        {profiles.map(p => <li key={p.user.id}>{p.user.username} — {p.points} pts</li>)}
      </ul>
    </div>
  )
}
