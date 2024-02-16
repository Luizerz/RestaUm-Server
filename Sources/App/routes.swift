import Vapor

func routes(_ app: Application) throws {

    let gameSystem = GameSystem()

    app.webSocket("game") { req, ws in
        gameSystem.connect(req, ws)
    }
}
