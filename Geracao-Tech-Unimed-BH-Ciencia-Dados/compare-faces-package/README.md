# compare_faces

## Description. 

The package compare_faces is used to:
	- Delimit face
	- Confront faces
	- Plot image
	- Plot result
	- Load image file

## Installation

Use the package manager [pip](https://pip.pypa.io/en/stable/) to install compare_faces

```bash
pip install compare_faces
```

## Usage

```python
import compare_faces as cf
image = cf.load_image_file("my_image.jpg")
image = cf.delimit_face(image)

# delimit_face returns an image with a rectangle delimiting the first face detected in the input image
```

```python
import compare_faces as cf
image = cf.load_image_file("my_image.jpg")
image_compare = cf.load_image_file("other_image.jpg")
result_message = confront_faces(image, image_compare)

# confront_image returns a string informing whether or not the faces belong to the same person and the distance between them

plot_result(image, image_compare, result_message)

# plot_result displays the images and the massage using matplotlib library
```

```python
import compare_faces as cf
image = cf.load_image_file("my_image.jpg")
plot_image(image)

# plot_image displays the image using matplotlib library
```

## Author
Ronaldo Nunes

## License
[MIT](https://choosealicense.com/licenses/mit/)