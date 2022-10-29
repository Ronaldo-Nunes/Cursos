from setuptools import setup, find_packages

with open("README.md", "r") as f:
    page_description = f.read()

with open("requirements.txt") as f:
    requirements = f.read().splitlines()

setup(
    name="compare_faces",
    version="0.0.1",
    author="Ronaldo Nunes",
    author_email="projetoftnunes@gmail.com",
    description="Pacote para comparação de duas faces",
    long_description=page_description,
    long_description_content_type="text/markdown",
    url="https://github.com/Ronaldo-Nunes/Cursos/tree/main/Geracao-Tech-Unimed-BH-Ciencia-Dados/compare-faces-package",
    packages=find_packages(),
    install_requires=requirements,
    python_requires='>=3.8'
)
    