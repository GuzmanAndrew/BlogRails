class ArticlesController < ApplicationController
    
    before_action :authenticate_user!, except: [:show, :index]
    before_action :set_article, except: [:index, :new, :create]
    

	#GET /articles
	# Es decir que es la ruta localhost:3000/articles
    def index
        #SELECT * FROM articles
        @articles = Article.paginate(page: params[:page], per_page:5)
    end

    #GET /article/:id,este es el id de la tabla con los articulos que
	#el usuario pidio
    def show
        # Encuentra un registro por su id
		#where
		# Article.where.not("id = ?, params[:id]")
        @comment = Comment.new
    end
    
    #GET /article/new, es el template donde crearemos los articulos
    def new
        @article = Article.new #el metodo "new" es para crear un nuevo objeto vacio, es decir
		# Los nuevos objetos se pueden instanciar con atributos vacíos o preestablecidos
		# pero aun sin ser grabados. En ambos casos la validación de los atributos se da con los 
		# nombres de las columnas de las tablas generadas.
		# en este caso esta accion "new" es nuestro articulo vacío
        @categories = Category.all
        @articles = Article.published
    end

    #POST /article, aca estamos creando el articulo que el usuario genero en la accion "new" 
    # y lo guardamos en nuestra base de datos
    def create
        # Aca estamos creando los atributos a nuestra tabla de la base de datos, con
		# los datos que el usuario genero en el template de "new"  
        # INSERT INTO
        @article = current_user.articles.new(article_params)

        # nuestras categorias

        @article.categories = params[:categories]

        # Luego debemos guardar este articulo, así:
        if @article.save
            redirect_to @article
        else
            render :new
        end

    end

    #DELETE /articles/:id
    def destroy
        #DELETE FROM articles

        @article.destroy #elimina el objeto de la BD
		redirect_to articles_path
    end

    #GET /articles/:id/edit
    def edit
        
    end

    def update
        # UPDATE
		# @article.update_attributes({title: "Nuevo titulo"})
        
        if @article.update(article_params)
            redirect_to @article
        else
            render :edit
        end
    end
   
    private 

    def set_article
        @article = Article.find(params[:id])
    end
    
    def article_params
        params.require(:article).permit(:title, :body, :cover, :categories)
    end

end