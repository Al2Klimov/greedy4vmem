FROM gcc as build
COPY main.c /
RUN ["gcc", "-O0", "-s", "-static", "-o", "greedy4vmem", "main.c"]


FROM alpine as compress
RUN ["apk", "add", "upx"]
COPY --from=build /greedy4vmem /
RUN ["upx", "/greedy4vmem"]


FROM scratch
COPY --from=compress /greedy4vmem /
CMD ["/greedy4vmem"]
HEALTHCHECK CMD ["/greedy4vmem"]
