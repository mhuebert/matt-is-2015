export default function errorHandler() {
  return function* (next) {
    try {
      yield next;
    } catch (err) {
      console.log("[[[Uncaught Error]]]", err, err.stack);
      this.status = 500;
      this.body = 'Sorry! Something went wrong.';
      this.app.emit('error', err, err.stack, this);
    }
  }
}

// TODO: return xhr errors for xhr requests, and an HTML page for GET requests.
