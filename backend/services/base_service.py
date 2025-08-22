# ========== CRUD GENERIC HELPER ==========
def update_instance(db_obj, update_data: dict):
    for key, value in update_data.items():
        setattr(db_obj, key, value)
    return db_obj