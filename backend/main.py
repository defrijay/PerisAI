from fastapi import FastAPI, File, UploadFile, HTTPException, status
from pydantic import BaseModel, EmailStr, Field
from typing import Optional, Annotated
import os

# UPLOAD_DIR = "uploaded_files"
# os.makedirs(UPLOAD_DIR, exist_ok=True)

class Item(BaseModel):
    name : str
    price : float
    
class UserRegister(BaseModel):
    username : str
    email : EmailStr
    password : str
    full_name : Optional[str] = None
    
class CartItem(BaseModel):
    product_id : int = Field(..., gt = 0, description="ID produk harus lebih besar dari 0")
    quantity : int = Field(..., gt = 0, le = 100, description = 'aiueo')
    

app = FastAPI()

@app.get('/')
async def root():
    return {'message' : 'Hello World'}

@app.post('/items')
async def create_item(item: Item):
    return item

@app.post('/register')
async def register_user(user: UserRegister):
    print(f'User {user.username} registeres with {user.email}')
    return {
        'message' : 'User registered successfully',
        'user_id' : 123
    }
    
@app.post('/cart/add')
async def add_to_cart(cart : CartItem):
    print(f"Adding product {cart.product_id} with quantity {cart.quantity} to cart.")
    return {"message": "cart added to cart successfully", "product_id": cart.product_id}
    
# @app.post('/upload/')
# async def create_upload_file(file: Annotated[UploadFile, File(description='file terserah pokoknya upload')]):
#     if not file.filename:
#         raise HTTPException(
#             status_code=status.HTTP_400_BAD_REQUEST,
#             detail='ish takde lah, mana file kau'
#         )
#     file_path = os.path.join(UPLOAD_DIR, file.filename)
    
#     try:
#         contents = await file.read()
#         with open(file_path, 'wb')as f:
#             f.write(contents)
#     except Exception as e:
#         raise HTTPException(
#             status_code=status.HTTP_500_INTERNAL_SERVER_ERROR,
#             detail='ada masalah koenksi kayanya bagn'
#         )
#     finally:
#         await file.close()
        
#     return {
#         "message": "File berhasil diunggah",
#         "filename": file.filename,
#         "content_type": file.content_type,
#         "file_size": len(contents),
#         "path": file_path
#     }
    
import tensorflow as tf
import numpy as np
import joblib
curr_dir = os.path.dirname(os.path.abspath(__file__))
model_path = os.path.join(curr_dir, '..', 'ml_model', 'model')
le_path = os.path.join(curr_dir, '..', 'ml_model', 'label_encoder.pkl')

_model = None
_label_encoder = None

def load():
    global _model, _label_encoder
    if _model is None:
        try:
            _model = tf.keras.models.load_model(model_path)
        except Exception as e:
            raise RuntimeError(f"Gagal memuat model TensorFlow dari {model_path}: {e}")
        
    if _label_encoder is None:
        try:
            _label_encoder = joblib.load(le_path)
        except Exception as e:
            raise RuntimeError(f"Gagal memuat LabelEncoder dari {le_path}: {e}")
        
    return _model, _label_encoder

@app.post('/predict')
async def predict():