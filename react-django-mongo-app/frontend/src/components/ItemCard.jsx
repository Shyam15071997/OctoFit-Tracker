import React from 'react';

const ItemCard = ({ item }) => {
    return (
        <div className="item-card">
            <h2>{item.name}</h2>
            <p>{item.description}</p>
            <p>Price: ${item.price}</p>
            <button>Add to Cart</button>
        </div>
    );
};

export default ItemCard;