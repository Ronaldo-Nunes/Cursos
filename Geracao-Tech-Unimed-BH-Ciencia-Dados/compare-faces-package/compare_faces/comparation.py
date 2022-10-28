from cv2 import rectangle
from face_recognition import face_locations
from face_recognition import face_encodings
from face_recognition import compare_faces
from face_recognition import face_distance

def _encode_image(image):
    return face_encodings(image)[0]

def _result_message(comparison_result, distance_images):
    if comparison_result:
        return f"Os rostos pertencem a mesma pessoa. Distância entra as faces: {distance_images}"
    else:
        return f"Os rostos são de pessoas distintas. Distância entra as faces: {distance_images}"

def delimit_face(image):
    face_location = face_locations(image)[0]
    rectangle(image, (face_location[3], face_location[0]), (face_location[1], face_location[2]), (0,255,0), 2)
    return image

def confront_faces(initial_image, compare_image):
    init_img = _encode_image(initial_image)
    comp_img = _encode_image(compare_image)
    comparison = compare_faces([init_img], comp_img)
    distance = face_distance([init_img], comp_img)
    return _result_message(comparison, distance)