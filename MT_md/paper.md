---
title: "Planar Quads in free-form Surfaces"
date: "September 2018"
author: "Christian Dimitri, UPC BarcelonaTech"
abstract:
    This chapter will discuss briefly the state of the art related to the Planar Quads Meshes, and how they are implemented in architecture. Therefore we will show the solutions behind the available softwares and the different techniques related to variantes researches achieved within this topic in the last twenty years. In addition to that we will try to cover all the techniques, by implementing them using the available tools.
bibliography: paper.bib
---

# Introduction

* Planar Quads(Definition)
* Statics-Sensitive Layout(Definition)
* Exhibit Properties
* Asthetical Properties

# Background

* Different techniques:
* Related works(State of the art)

# Case Study

## Architectural Implmentations (Real Architecture Projects)

* Railway station B.Schneider [@liu2006geometric] - Conical meshes.

![Railway station](MT_JPG/ConicalMeshes.jpg){#fig:Railwaystation}

* Roof over the Bosch Areal courtyards [@glymph2004parametric] - Grid dome as translational surface with planar mesh.

![Roof over the Bosch courtyards](MT_JPG/BoschRoof.jpg){#fig:BoschRoof}




## Software Solutions 

* Evolute
* Kangaroo2

## Techniques

### Free-Form Surfaces

#### PQ Meshes as Conical Meshes

##### What are conical meshes in theory ?

![Faces Configuration of a Conical Ceshes](MT_JPG/facesConfiguration.jpg){#fig:facesConfiguration}

![Constant offset of a Conical Mesh](MT_JPG/Constant Offset of Conical Meshes.jpg){#fig:ConicalMeshes}

##### The relation between PQ meshes and conjugate networks:

###### Conjugate Surface Tangents as seen in [@fig:conjugacyContours]
![Conjugacy Via Shadow Contours](MT_JPG/conjugacyViaShadowContours.png){#fig:conjugacyContours}

###### Various Conjugate Networks on Surfaces as seen in [@fig:conjugateNetworks]
![Various Conjugate Networks](MT_JPG/variousConjugateNetworks.jpg){#fig:conjugateNetworks}



##### PQ Perturbation:

  * Quad mesh as input with vertices $\mathbf{v}{_i}{_,}{_j}$
  * minimally perturb the vertices into a new positions while maintaining the PQ meshes properties.

    
  * Penalty Linear fonctunality combination:

    1. $Q{_i}{_,}{_j}$ is convex and planar if and only if the sum of angles is equals to $2\pi$:
    

        $$c{_p}{_q}=\alpha{^1}{_i}{_,}{_j}+ ... + \alpha{^4}{_i}{_,}{_j} - 2\pi = 0.$$ {#eq:angles}

        Another Planarity Constraints on all the $\mathbf{v}\scriptsize{i,j}$, while computing the unit vectors along the egdes of each face consider the determinant on each edge equals to zero: $\mathbf{\lambda}{^T}{_d}{_e}{_t}c{_d}{_e}{_t}=0.$
    
    2. Two energies terms:
    
       * Fairness (which simplifies the bending energies in the rows and columns on each polygon of the mesh):
       
       $$f{_f}{_a}{_i}{_r} = {\large{\sum}}{_i}{_,}{_j}{\large{[(}}{\mathbf{v}}{_i}{_+}{_1}{_,}{_j} - 2 {\mathbf{v}}{_i}{_,}{_j} + {\mathbf{v}}{_i}{_-}{_1}{_j}{\large{)}}{^2} + {\large{(}}{\mathbf{v}}{_i}{_,}{_j}{_+}{_1} - 2 {\mathbf{v}}{_i}{_,}{_j} + {\mathbf{v}}{_i}{_,}{_j}{_-}{_1}{\large{)}}{^2}{\large{]}}.$$


       * Closeness:

            While the polygons are defined as squares, this fonction minimizes the distance between the original surface $\Phi$ and the vertices $\mathbf{v}\scriptsize{i,j}$ of the perturbed mesh, where ${\mathbf{y}}{\scriptsize{i,j}}.$ are the closest points to the mesh, otherwise the undifined squares are set to zero :

         $$f{_c}{_l}{_o}{_s}{_e} = {\large{\sum}}{_i}{_,}{_j} ||{\mathbf{v}}{_i}{_,}{_j} - {\mathbf{y}}{_i}{_,}{_j}||{^2}.$$ 

    3. SQP(Sequential Quadratic Programming)
    
        As subject to the constraints above the Langrangian functions is written as follow:
        
        $$f{_P}{_Q}=w{_1}f{_f}{_a}{_i}{_r}+w{_2}f{_c}{_l}{_o}{_s}{_e}+\mathbf{\lambda}{^T}{_p}{_q}c{_p}{_q}+\mathbf{\lambda}{^T}{_d}{_e}{_t}c{_d}{_e}{_t}$${#eq:langrangian}
        The SQP minimizes the fairness and closeness subject to the planarity constraints of $f{_P}{_Q}$. While $w{_1}$ and $w{_2}$ are user spicified constants to control fairness and closeness.
    
        SQP works only for up to 1000 vertices per mesh

        
        
    4. Therefore another function by combining the constraints in {@eq:angles} by summing up the angles on all the polygons. In addition to that a final function is added to minimize the objectives in {@eq:langrangian}.
        

##### Subdiving PQ meshes:

Using a quad based subdivision algorithm such as Catmull-Clark and Doo-Sabin. after subdividing the corse mesh, another PQ perturbation is made as seen in [@fig:subdivided]

![Corse Mesh Subdivision and PQ perturbation sequence](MT_JPG/subdivision.jpg){#fig:subdivided}



#### PQ Meshes by Conjugate Direction Fields (CDF)[@liu2011general]
The main study of a CDF is to define a correct smoothness measure to allow $\pm k/4$.
The study of conugate direction fields allow the presence of singularities with indices $\pm k/4 (k\in Z)$

##### CDF on Triangle Meshes
* What is a CDF on a triangular face $f{_i}$? as seen in [@fig:singleCDF]

![CDF on a Triangular face](MT_JPG\Conjugate directions on a triangular Face.jpg){#fig:singleCDF}

Smooth Surface  $S \subset {\Bbb R}{^3},$ 

$v{_p},w{_p}$ are conjugate if and only if they are treated as two vectors in ${\Bbb R}{^3}$, $e{_i}{_,}{_1}$ is the principal direction.

{$v{_i},w{_i},-v{_i},-w{_i}$ } four vectors that can be parametrized by { $\theta,\alpha$ } where:
$\theta{_i}$ is the oriented angle between $e{_i}{_,}{_1}$ and $v{_i}$ and $\alpha{_i}$ is the oriented angle between $e{i}{_,}{_1}$ and $v{_i}$. Therefore:
$$v{_i}=(cos\theta{_i}, sin\theta{_i}){^T}$$
$$w{_i}=(cos(\theta{_i} + \alpha{_i}), sin(\theta{_i} + \alpha{_i})){^T}$$

* Smoothness of a CDF

  * The smoothness is computed at each edge $e{_i}{_j}$ incident to two triangles faces $f{_i},f{_j}$

  * The angle $C{_1}(e{_i}{_j}),C{_1}(e{_i}{_j})$ difference are computed between the associated direction vectors which are called *discrete connection* they measure the change of the conjugate directions between the pair of vectors. In addition to that two angle differences need to be computed since at each face f there are two directions.



![difference between smoothed and none smoothed CDF](MT_JPG\difference.jpg){#fig:difference}

* Index of singularities


##### CDF Optimization




##### PQ Mesh Generation

##### CDF Optimization


#### PQ Meshes by Level Set Method [@zadravec2010designing]
Allows the presence of singularities with indices $\pm k/2 (k\in Z)$


#### PQ Meshes by statics-sensitive layout [@schiftner2010statics]

##### Quad dominant mesh by a stress directional field


### Translational Surfaces



# References